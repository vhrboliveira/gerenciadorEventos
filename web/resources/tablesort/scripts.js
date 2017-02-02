$(function(){
	// Parser para configurar a data para o formato do Brasil
	$.tablesorter.addParser({
		id: 'datetime',
		is: function(s) {
			return false; 
		},
		format: function(s,table) {
			s = s.replace(/\-/g,"/");
			s = s.replace(/(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})/, "$3/$2/$1");
			return $.tablesorter.formatFloat(new Date(s).getTime());
		},
		type: 'numeric'
	});

	$('.tablesorter').tablesorter({
        // Envia os cabeçalhos 
        headers: { 
            // A sgunda coluna (começa do zero) 
            1: { 
                // Desativa a ordenação para essa coluna 
                sorter: false 
            },
			2: { 
                // Desativa a ordenação para essa coluna 
                sorter: false 
            },
			3: { 
                // Desativa a ordenação para essa coluna 
                sorter: false 
            },
			4: {
                // Ativa o parser de data na coluna 4 (começa do 0) 
                sorter: 'datetime' 
			},
			6: { 
                // Desativa a ordenação para essa coluna 
                sorter: false 
            },
			7: { 
                // Desativa a ordenação para essa coluna 
                sorter: false 
            }
        },
		// Formato de data
		dateFormat: 'dd/mm/yyyy'
	});
});
