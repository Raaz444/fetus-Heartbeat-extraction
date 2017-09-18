function qadr(a,b,c)

if b^2-4*a*c > 0

   r1=(-b+sqrt(b^2-4*a*c))/2*a
   r2=(-b-sqrt(b^2-4*a*c))/2*a
else if b^2-4*a*c == 0

   r=-b/2*a
   else 
disp(' No real solution')

   end 
end

end