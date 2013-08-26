# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('[id*=table-requirements-fields-]').tableDnD
		onDrop: (table,row) ->
			console.log row.sectionRowIndex
			console.log table.id.replace('table-requirements-fields-','')
			table_id = table.id.replace('table-requirements-fields-','')
			$.ajax
				type: "POST"
				url:  "/projects/"+table_id+"/update_order"
				data: 
					field: row.id
					order: (row.sectionRowIndex) + 1
				success: (data) ->
					console.log data
				error: (data) ->
					console.log data