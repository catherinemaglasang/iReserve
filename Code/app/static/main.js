$(document).ready(function(){
	console.log("ready!");

	$("form").on("submit", function(){
		console.log("the form has been submitted!");

		var valueOne = $('input[name="email"]').val()
		var valueTwo = $('input[name="password"]').val()
		var valueThree = $('input[name="fname"]').val()
		var valueFour = $('input[name="lname"]').val()
        var valueFive = $('input[name="signup-gender"]').val(),
    		converted_valueFive = parseInt(valueFive, 10);

		var valueSix = $('input[name="number"]').val()
		var valueSeven = $('input[name="birthday"]').val()
		var valueEight = $('input[name="address"]').val()
		var valueNine = $('input[name="postal"]').val()
		console.log(valueOne, valueTwo, valueThree, valueFour, converted_valueFive, valueSix, valueSeven, valueEight, valueNine);

		$.ajax({
			type: "POST",
			url: "/api/register",
			data: {first:valueOne, second:valueTwo, third:valueThree, fourth:valueFour, fifth:converted_valueFive, sixth:valueSix, seventh:valueSeven, eighth:valueEight, ninth:valueNine},
			success: function(results){
				alert("success")
				
			},
			error: function(error){
				console.log(error);
			},
		});
	});

});