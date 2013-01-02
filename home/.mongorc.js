print("Loading .mongorc.js")

// Convenience function to load file with temporary commands

l = function() {
	load("/home/cstevens/.mongorc.js");
	load("/home/cstevens/.mongoalt.js");
};

// General functions

bytesToReadable = function(bytes) {
	if (bytes == 0)
		return "0 B";
	var suffixes = [ "B", "KB", "MB", "GB", "TB", "PB" ];
	var base = Math.ceil(Math.log(bytes) / Math.log(1024));
	base = Math.max(0, Math.min(base, suffixes.length - 1));
	var testRescaled = bytes / Math.pow(1024, base);
	if (testRescaled < 0.9) {
		base--;
	}
	var rescaled = bytes / Math.pow(1024, base);
	var roundPlaces = rescaled > 1 ? 1 : 2;
	return roundDecimalPlaces(rescaled, roundPlaces) + " " + suffixes[base];
};

roundDecimalPlaces = function(num, places) {
	return Math.round(num * Math.pow(10, places)) / Math.pow(10, places);
};

propertyCount = function(obj) {
	var count = 0;
	for (var prop in obj)
		if (obj.hasOwnProperty(prop)) {
			count++;
		}
	return count; 
};

isStringEmpty = function(str) {
	return (!str || str.length === 0);
};

var ObjectHandler = {
    getCloneOfObject: function(oldObject) {
        var tempClone = {};

        if (typeof(oldObject) == "object")
            for (prop in oldObject)
                // for array use private method getCloneOfArray
                if ((typeof(oldObject[prop]) == "object") &&
                                (oldObject[prop]).__isArray)
                    tempClone[prop] = this.getCloneOfArray(oldObject[prop]);
                // for object make recursive call to getCloneOfObject
                else if (typeof(oldObject[prop]) == "object")
                    tempClone[prop] = this.getCloneOfObject(oldObject[prop]);
                // normal (non-object type) members
                else
                    tempClone[prop] = oldObject[prop];

        return tempClone;
    },

    getCloneOfArray: function(oldArray) {
        var tempClone = [];

        for (var arrIndex = 0; arrIndex <= oldArray.length; arrIndex++)
            if (typeof(oldArray[arrIndex]) == "object")
                tempClone.push(this.getCloneOfObject(oldArray[arrIndex]));
            else
                tempClone.push(oldArray[arrIndex]);

        return tempClone;
    }
};

// Modify intrinsic JavaScript prototypes

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] === obj) {
            return true;
        }
    }
    return false;
};

// MongoDB-specific

prompt = function() {
	colors = [ "\033[1;37m", "\033[1;36m", "\033[1;34m" ];
	closeColor = "\033[0m";
	
	rsName = rs.status().set;	
	hostTokens = db.serverStatus().host.split(":");
	host = hostTokens[0].split(".")[0];
	port = hostTokens.length > 1 ? ":" + hostTokens[hostTokens.length - 1] : "";
	promptStr = "";
	if (rsName)
		promptStr += colors[0] + "(" + rsName + ") " + closeColor;
	promptStr += colors[1] + host + port + closeColor + "/" + colors[2] + db + closeColor + "> ";
	return promptStr;
};

objToReadable = function(obj, parent) {
	var sizeFields = [ "dataSize", "indexSize", "storageSize", "fileSize", "avgObjSize", "size", "lastExtentSize", "totalIndexSize" ];
	var parentSizeFields = [ "indexSizes" ];
	switch (obj.constructor) {
		case bson_object:
		case Object:
			for (field in obj) {
				if (parent) {
					// Subdocument
					if (obj[field].constructor == Number &&
						(sizeFields.contains(field) || parentSizeFields.contains(parent)))
						obj[field] = bytesToReadable(obj[field]);
					else
						obj[field] = objToReadable(obj[field]);
				} else {
					// Not subdocument
					if (obj[field].constructor == Number &&
						sizeFields.contains(field))
						obj[field] = bytesToReadable(obj[field]);
					else
						obj[field] = objToReadable(obj[field], field);
				}
			}
			return obj;
			break;
		default:
			return obj;
			break;
	}
};

if (!("statsRaw" in DB.prototype)) {
	DB.prototype.statsRaw = DB.prototype.stats;
	delete DB.prototype.stats;
	DB.prototype.stats = function() {
		return objToReadable(this.statsRaw());
	};
};

if (!("statsRaw" in DBCollection.prototype)) {
	DBCollection.prototype.statsRaw = DBCollection.prototype.stats;
	delete DBCollection.prototype.stats;
	DBCollection.prototype.stats = function() {
		return objToReadable(this.statsRaw());
	};
};

if (!("forCollection" in DB.prototype)) {
	DB.prototype.forCollection = function(f) {
		var colNames = db.getCollectionNames();
		for (var a = 0; a < colNames.length; a++) {
			var c = db.getCollection(colNames[a]);
			f(c);
		}
	};
};

if (!("forCollectionObj" in DB.prototype)) {
	DB.prototype.forCollectionObj = function(f) {
		var ret = [];
		var colNames = db.getCollectionNames();
		for (var a = 0; a < colNames.length; a++) {
			var c = db.getCollection(colNames[a]);
			ret.push(f(c));
		}
		return ret;
	};
};

asDb = function(str) {
	return db.getSiblingDB(str);
};

if (!("currentUserOp" in DB.prototype)) {
	DB.prototype.currentUserOp = function() {
		var op = db.currentOp();
		var userInprog = op.inprog.filter(function(obj) {
			return obj.ns != "" && obj.ns != "local.oplog.rs";
		});
		delete op.inprog;
		op.inprog = userInprog;
		return op;
	};
};
