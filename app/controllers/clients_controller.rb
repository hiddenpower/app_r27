class ClientsController < ApplicationController
 before_filter :authenticate_admin!, :only => [:show, :edit, :update, :destroy, :index]


  # GET /clients
  # GET /clients.json

  helper_method :sort_column, :sort_direction

  include ApplicationHelper
  def index
    @clients = Client.order(sort_column + " " + sort_direction)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end


  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to gracias_path }
        format.json { render json: @client, status: :created, location: @client }
      require 'rubygems'
      require 'tlsmail'
      require 'time'
      
      send_mail_to(@client.email, "Gracias por contratar")
      
      @admins = Admin.all
      @admins.each do |admin|
        send_mail_to(admin.email, "Una nueva orden de servicio ha sido creada")
      end
      
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_admin
        send_mail_to(params[:email], "Clic aqui para crear tu cuenta: http://r27.kiwinetworks.com/admins/sign_up")
        redirect_to root_path
  end

 def send_sol
        @admins = Admin.all
        @admins.each do |admin|
        send_mail_to(admin.email, "The user email is #{params[:email]}") 
      end
        redirect_to root_path
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'El registro fue actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
