function out = SVMTest(data,classifier,params)
  if isfield(params,'path') && exist(params.path,'dir'),
    addpath(params.path)
  else,
    error('Error: Parameter.base_params.path should point to liblinear''s matlab directory.')
  end
  paramStr = '-q';

  % since we aren't going to use predict's accuracy, etc. just make up some labels to use
  labels = ones(size(data,1),1);
  out = predict(labels,sparse(data),classifier,paramStr);

  rmpath(params.path)
