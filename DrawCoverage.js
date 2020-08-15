function DrawCoverage(text)
{
var obj = JSON.parse(text);

document.getElementById("demo").innerHTML =
obj.coverage[0].BuildNumber + " " + obj.coverage[0].BranchCoverage+" %";

var ctx = document.getElementById("myChart").getContext("2d");
var data = { labels : [],
			 datasets : []
			};
var lineCoverage = {
            label: "Line Coverage",
            //fillColor: "rgba(220,220,220,0.2)",
			fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
			data : []
			};
var branchCoverage = {
            label: "Branch Coverage",
            //fillColor: "rgba(151,187,205,0.2)",
			fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
			data : []
			};

for( var i=obj.coverage.length-1;i>=0; i--) {
	data.labels.push(obj.coverage[i].BuildNumber);
	branchCoverage.data.push(obj.coverage[i].BranchCoverage);
	lineCoverage.data.push(obj.coverage[i].LineCoverage);
}


data.datasets.push(lineCoverage);
data.datasets.push(branchCoverage);


var myLineChart = new Chart(ctx).Line(data,  
		{
			bezierCurve: false, 
			animation: true, 
			animationSteps:5,
			scaleOverride : true,
			scaleStartValue : 0,
			scaleSteps : 10,
			scaleStepWidth : 10
		}
);

}