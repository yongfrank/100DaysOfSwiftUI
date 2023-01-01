/**
 This code defines a new JavaScript object called Action that has two methods: run and finalize.
 The Action object is created using the function keyword and is then given a prototype object that contains these two methods.

 The run and finalize methods are functions that take a single parameter called parameters.
 These methods can be called on any object that is created using the Action constructor.

 Finally, a new object called ExtensionPreprocessingJS is created using the Action constructor.
 This object will have the run and finalize methods available to it.

 It's worth noting that this code uses the old-style syntax for creating objects in JavaScript.
 In modern JavaScript, you might see this code written using the class keyword instead.
 */

var Action = function() {};

Action.prototype = {
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},
    
finalize: function(parameter) {
    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript);
}
};

var ExtensionPreprocessingJS = new Action
