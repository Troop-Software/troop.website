$ ->
  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link)
    false

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    html = """
           <div class="modal" id="confirmationDialog">
             <div class="modal-dialog">
               <div class="card card-stats">
                  <div class="card-header" data-background-color="red">
                    <i class='material-icons'>delete</i></i>
                  </div>
                  <div class="modal-content">
                     <div class="modal-header">
                       <a class="close" data-dismiss="modal">×</a>
                       <h4>#{message}</h4>
                    </div>
                    <div class="modal-footer">
                       <a data-dismiss="modal" class="btn">Cancel</a>
                      <a data-dismiss="modal" class="btn btn-danger confirm">Ok</a>
                    </div>
                  </div>
               </div>
             </div>
           </div>
           """
    $(html).modal('show')
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)