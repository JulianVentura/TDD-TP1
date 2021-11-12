Sequel.migration do
  up do
    add_column :job_offers, :postulants, Integer, default: 0
  end

  down do
    drop_column :job_offers, :postulants
  end
end
