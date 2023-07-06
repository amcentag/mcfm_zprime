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
      real(dp):: gz,gkm
      integer:: model
      sin2w=two*sqrt(xw*(1._dp-xw))

      ! contrib = 0: photon only (Z couplings set to zero)
      ! contrib = 1: photon/Z
      ! contrib = 2: photon/Z'
      contrib = 0

        if (model == 0) then
            do j=1,nf
                l(j) = 0._dp
                r(j) = 0._dp
            enddo
            le = 0._dp
            re = 0._dp
            ln = 0._dp
            rn = 0._dp
        endif

      if (model == 1) then
          do j=1,nf
          l(j)=(tau(j)-two*Q(j)*xw)/sin2w
          r(j)=      (-two*Q(j)*xw)/sin2w
          enddo

          le=(-1._dp-two*(-1._dp)*xw)/sin2w
          re=(-two*(-1._dp)*xw)/sin2w

          ln=(+1._dp-two*(+0._dp)*xw)/sin2w
          rn=0._dp
      endif

        ! heterotic string model charges from 1807.08031, Table 3, pg 14
        if (model == 2) then
            do j=1,nf
            l(j) = -2._dp/5._dp/sin2w*gz + 1._dp/6._dp/sin2w*gkm
            enddo
            r(1) = -4._dp/5._dp/sin2w*gz - 1._dp/3._dp/sin2w*gkm
            r(2) = -2._dp/5._dp/sin2w*gz + 2._dp/3._dp/sin2w*gkm
            r(3) = -4._dp/5._dp/sin2w*gz - 1._dp/3._dp/sin2w*gkm
            r(4) = -2._dp/5._dp/sin2w*gz + 2._dp/3._dp/sin2w*gkm
            r(5) = -4._dp/5._dp/sin2w*gz - 1._dp/3._dp/sin2w*gkm

            le = -4._dp/5._dp/sin2w*gz - 1._dp/2._dp/sin2w*gkm
            re = -2._dp/5._dp/sin2w*gz - 1._dp/sin2w*gkm
            ln = -4._dp/5._dp/sin2w*gz
            rn = 0._dp
        endif

      return
      end
