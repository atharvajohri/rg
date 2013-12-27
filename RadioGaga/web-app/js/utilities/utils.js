Utils = {};

Utils.mapObject = function(fromObject, toObject, ignoreList, notExact, notDeep){
    if (!ignoreList)
    	ignoreList = [];
    for(var key in fromObject) {
        if(fromObject.hasOwnProperty(key)){
            if (!Utils.inArray(key, ignoreList)){
                if (toObject.hasOwnProperty(key) && Utils.isFunction(toObject[key])){
                	if(!notDeep && !Utils.isArray(fromObject[key]) && typeof fromObject[key] === "object") {
                		if (toObject[key]() != undefined || toObject[key]() != null)
                			Utils.mapObject(fromObject[key], toObject[key](), ignoreList, notExact);
                	} else {
                		toObject[key](fromObject[key]);
                	}
                } else {
                    if (notExact){
                        if (toObject.hasOwnProperty(key)){
                        	toObject[key] = fromObject[key];
                        }
                    }else{
	                    toObject[key] = fromObject[key];
                    }                                                                                                              
                }
            }                                                              
        }              
    }
    return toObject;
}

Utils.inArray = function(needle,haystack) {
    var count=haystack.length;
    for(var i=0;i<count;i++) {
        if(haystack[i]===needle){return true;}
    }
    return false;
}

Utils.isFunction = function(value) {
	if (value === undefined || value === null) {
		return false;
	}
	return typeof value === 'function';
};

Utils.isArray = function (vArg) {
	return Object.prototype.toString.call(vArg) === "[object Array]";
};
