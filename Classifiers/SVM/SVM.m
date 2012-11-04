function [classifier] = SVM(posData,negData,params)
  if isfield(params,'path') && exist(params.path,'dir'),
    addpath(params.path)
  else,
    error('Error: Parameter.base_params.path should point to liblinear''s matlab directory.')
  end
  % create a parameter string for liblinear from fields in params
  paramStr = '-q';
  if isfield(params,'s')
    paramStr = [paramStr,sprintf(' -s %d',params.s)];
  end
  if isfield(params,'c')
    paramStr = [paramStr,sprintf(' -c %f',params.c)];
  end
  if isfield(params,'p')
    paramStr = [paramStr,sprintf(' -p %f',params.p)];
  end
  if isfield(params,'e')
    paramStr = [paramStr,sprintf(' -e %f',params.e)];
  end
  if isfield(params,'B')
    paramStr = [paramStr,sprintf(' -B %d',params.B)];
  end
  if isfield(params,'v')
    paramStr = [paramStr,sprintf(' -v %d',params.v)];
  end

  labels = [ones(size(posData,1),1);-ones(size(negData,1),1)];
  data = sparse([posData;negData]);
  classifier = train(labels,data,paramStr);

  rmpath(params.path)
