class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy,
                                  :public_show, :redirect]
  before_filter :authenticate_user!, except: [:redirect, :public_new, :public_show]

  def redirect
    redirect_to @link.target_url
  end

  def public_new
    @link = Link.new
  end

  def public_show
  end

  def public_create
    @link = Link.new(link_params)

    unless @link.target_url.starts_with?('http')
      @link.target_url = "http://#{@link.target_url}"
    end

    respond_to do |format|
      if @link.save
        format.html { redirect_to public_show_url(@link.short_name),
                                  notice: 'Link was successfully created.' }
      else
        format.html { render action: 'public_new' }
      end
    end
  end

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      if params[:short_name]
        @link = Link.where(short_name: params[:short_name]).first
      else
        @link = Link.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:target_url, :short_name)
    end
end
