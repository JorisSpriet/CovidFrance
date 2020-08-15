function tableCreate(values) {
        var tbdy = document.getElementById('coveragesummarytable');

        //rows       
        values.forEach(function (value) {
            var row = tbdy.insertRow(0);
            var columnnames = ['FullClassName', 'NumberOfCoverableLines', 'NumberOfCoveredLines', 'LineCoverage', 'CoverageResult'];
            for (i = 0; i < columnnames.length; i++) {
                var c = row.insertCell(-1);
                c.className = columnnames[i];
                c.innerHTML = value[columnnames[i]];
            }
            
            switch (value['CoverageResult']) {
                case 'Status quo':
                    row.cells[4].style['background-color'] = 'DarkSeaGreen';
                    break;
                case 'Increased':
                    row.style['background-color'] = 'Green';
                    break;
                case 'Decreased':
                    row.style['background-color'] = 'IndianRed';
                    break;
            }
            
        });
    }