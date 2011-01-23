class QAsController < ApplicationController
  # GET /qas
  # GET /qas.xml
  def index
    @qas = QA.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @qas }
    end
  end

  # GET /qas/1
  # GET /qas/1.xml
  def show
    @qa = QA.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @qa }
    end
  end

  # GET /qas/new
  # GET /qas/new.xml
  def new
    @qa = QA.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @qa }
    end
  end

  # GET /qas/1/edit
  def edit
    @qa = QA.find(params[:id])
  end

  # POST /qas
  # POST /qas.xml
  def create
    @qa = QA.new(params[:qa])

    respond_to do |format|
      if @qa.save
        format.html { redirect_to(@qa, :notice => 'QA.was successfully created.') }
        format.xml  { render :xml => @qa, :status => :created, :location => @qa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @qa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /qas/1
  # PUT /qas/1.xml
  def update
    @qa = QA.find(params[:id])

    respond_to do |format|
      if @qa.update_attributes(params[:qa])
        format.html { redirect_to(@qa, :notice => 'QA.was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @qa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /qas/1
  # DELETE /qas/1.xml
  def destroy
    @qa = QA.find(params[:id])
    @qa.destroy

    respond_to do |format|
      format.html { redirect_to(qas_url) }
      format.xml  { head :ok }
    end
  end
end
