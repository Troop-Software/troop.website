class Admin::FileUploadsController < AdminController
  before_action :set_admin_file_upload, only: [:destroy]

  # GET /admin/file_uploads
  # GET /admin/file_uploads.json
  def index
    @admin_file_uploads = Admin::FileUpload.all
  end


  # GET /admin/file_uploads/new
  def new
    @admin_file_upload = Admin::FileUpload.new
  end


  # POST /admin/file_uploads
  # POST /admin/file_uploads.json
  def create
    @admin_file_upload = Admin::FileUpload.new(admin_file_upload_params)

    respond_to do |format|
      if @admin_file_upload.save
        format.html { redirect_to admin_file_uploads_path, notice: 'File upload was successfully created.' }
        format.json { render :back, status: :created, location: admin_file_uploads_path }
      else
        format.html { render :new }
        format.json { render json: @admin_file_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/file_uploads/1
  # DELETE /admin/file_uploads/1.json
  def destroy
    @admin_file_upload.destroy
    respond_to do |format|
      format.html { redirect_to admin_file_uploads_url, notice: 'File upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_file_upload
      @admin_file_upload = Admin::FileUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_file_upload_params
      params.require(:admin_file_upload).permit(:user_id, :file)
    end
end
