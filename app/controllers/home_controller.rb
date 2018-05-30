class HomeController < ApplicationController
  before_action :check_log_in, only: [:show, :get_list]

  require 'open-uri'
  require 'json'
  require 'will_paginate/array'

  def index
  end

  def show 
  end

  def get_list  # dropdown list로 지역을 설정해서, 해당 지역 api 받아오는 액션
    case params[:location]
    when "1"
    url = "http://openapi.songpa.seoul.kr:8088/" +ENV["seoul_sp_api_key"] + "/json/SpListTelemarketing/1/1000"
    when "2"
    url = "http://openapi.gangnam.go.kr:8088/" + ENV["seoul_gn_api_key"]+ "/json/GnListTelemarketing/1/1000"
    when "3"
    url = "http://openapi.jongno.go.kr:8088/" + ENV["seoul_jn_api_key"]+ "/json/JongnoListTelemarketing/1/1000"
    when "4"
    url = "http://openapi.gangseo.seoul.kr:8088/"+ ENV["seoul_gs_api_key"] +"/json/GangseoListTelemarketing/1/1000"
    when "5"
    url = "http://openapi.sb.go.kr:8088/" + ENV["seoul_sb_api_key"]+ "/json/SbListTelemarketing/1/1000"
    end

    doc = JSON.load(open(url))
    doc_list = doc.values.first["row"]


    $filtered_list = []
    doc_list.each do |alist|
      if alist["MNG_STATE_NM"] != "폐업" && alist["MNG_STATE_NM"] != "직권말소"
        $filtered_list.push(alist)
      end
    end

    $num_of_pages = ($filtered_list.length / 20.0).ceil
    @paginated_list = $filtered_list.paginate(page: 1, per_page: 20)
    @start_num = 1
    render 'home/show'
  end

  def paginate_list # 각각의 paginate된 목록을 불러오기
    @start_num = ((params[:page].to_i) - 1) * 20 + 1
    @paginated_list = $filtered_list.paginate(page: params[:page], per_page: 20)
    render 'home/show'
  end

  def check_log_in
    unless user_signed_in?
      redirect_to show_path
    end
  end
end
