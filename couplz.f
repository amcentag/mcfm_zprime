!  Copyright (C) 2019-2021, respective authors of MCFM.
!
!  This program is free software: you can redistribute it and/or modify it under
!  the terms of the GNU General Public License as published by the Free Software
!  Foundation, either version 3 of the License, or (at your option) any later
!  version.
!
!  This program is distributed in the hope that it will be useful, but WITHOUT ANY
!  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
!  PARTICULAR PURPOSE. See the GNU General Public License for more details.
!
!  You should have received a copy of the GNU General Public License along with
!  this program. If not, see <http://www.gnu.org/licenses/>
 
      subroutine couplz(xw)
      implicit none
      include 'src/Inc/types.f'
             
      include 'src/Inc/constants.f'
      include 'src/Inc/nf.f'
      include 'src/Inc/mxpart.f'
      include 'src/Inc/cplx.h'
      include 'src/Inc/zcouple.f'
      include 'src/Inc/ewcharge.f'
c---calculate the couplings as given in Kunszt and Gunion
c---Modified to notation of DKS (ie divided by 2*sw*cw)
c---xw=sin^2 theta_w
      integer:: j
      real(dp):: xw
      sin2w=two*sqrt(xw*(1._dp-xw))
      do j=1,nf
      l(j)=(tau(j)-two*Q(j)*xw)/sin2w
      r(j)=      (-two*Q(j)*xw)/sin2w
      enddo

      le=(-1._dp-two*(-1._dp)*xw)/sin2w
      re=(-two*(-1._dp)*xw)/sin2w

      ln=(+1._dp-two*(+0._dp)*xw)/sin2w
      rn=0._dp

      return
      end
