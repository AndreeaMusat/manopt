function cdotprodAB = cdotprod(A, B)
% Computes the element-wise multiplication between A and B
%
% function cdotprodAB = cdotprod(A, B)
%
% Returns the element-wise multiplication of A and B. The inputs A and B 
% can be either numeric arrays or structs with fields real and imag.
%
% See also: manoptAD

% This file is part of Manopt: www.manopt.org.
% Original author: Xiaowen Jiang, July 31, 2021.
% Contributors: Nicolas Boumal
% Change log: 

    if isnumeric(A) && isnumeric(B)
        cdotprodAB = A .* B;
        
    elseif iscstruct(A) || iscstruct(B)
        A = tocstruct(A);
        B = tocstruct(B);
        cdotprodAB.real = A.real .* B.real - A.imag .* B.imag;
        cdotprodAB.imag = A.real .* B.imag + A.imag .* B.real;
        
    else
        ME = MException('cprod:inputError', ...
                        'Input does not have the expected format.');
        throw(ME);
        
    end

end

function flag = iscstruct(A)
    flag = ( isstruct(A) && isfield(A, 'real') && isfield(A, 'imag') );
end

function B = tocstruct(A)
    if iscstruct(A)
        B = A;
    elseif isnumeric(A)
        B.real = real(A);
        B.imag = imag(A);
    else
        error('Input does not have the expected format.');
    end
end
