{\rtf1\ansi\ansicpg1252\cocoartf1671
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 require "csv"\
\
namespace :db do\
  desc "Imports zipcodes from the CSV file"\
  task zipcodes: :environment do\
    Zipcode.destroy_all\
\
    CSV.foreach("db/zipcodes.csv", headers: true) do |line|\
      code = line.to_hash["Postcode"]\
      Zipcode.create!(code: code) if code.present?\
    end\
  end\
end}