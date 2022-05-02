({
	init : function(component, event, helper) {
		helper.getOpportunityDetails(component, helper);
	},

	nextStepClicked: function(component, event, helper) {		
		helper.nextStep(component, helper);
	},	

	previousStepClicked: function(component, event, helper) {
		helper.lastStep(component);
	},

	cancelClicked: function(component, event, helper) {
		helper.cancel(component);
	},

	finishClicked: function(component, event, helper) {
		helper.cancel(component);
	},

	handleDirectDebitChanged: function (component, event, helper) {
        var checkout = component.get('v.checkout');
        helper.modulusCheckDirectDebit(component, helper, checkout);
	},
    closeClicked: function(component, event, helper) {
		helper.close(component);
	},
	iframeLoaded: function(component, event, helper){
		helper.toggleSpinner(component, false);
	}
})