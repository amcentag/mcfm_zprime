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

module nplotter_Z
      use types
      use MCFMPlotting
      use ResummationTransition, only: transition
      use qtResummation_params, only: transitionSwitch
      implicit none

      public :: setup, book
      private

      integer, save, allocatable :: histos(:)

      contains

      subroutine setup()
          use types
          use parseinput
          implicit none
          include 'src/Inc/mpicommon.f'

          allocate(histos(2))

          if (rank == 0) then
              write (*,*) "RESUMMATION: Using transition with switch ", transitionSwitch
          endif

!          histos(1) = plot_setup_custom([0.0010d0,0.0013d0,0.0016d0,0.0020d0, &
!                0.0025d0,0.0032d0,0.0040d0,0.0050d0,0.0063d0,0.0079d0, &
!                0.0100d0,0.0126d0,0.0158d0,0.0200d0,0.0251d0,0.0316d0, &
!                0.0398d0,0.0501d0,0.0631d0,0.0794d0,0.1000d0,0.1259d0, &
!                0.1585d0,0.1995d0,0.2512d0,0.3162d0,0.3981d0,0.5012d0, &
!                0.6310d0,0.7943d0,1.0000d0,1.2589d0,1.5849d0,1.9953d0, &
!                2.5119d0,3.1623d0,3.9811d0,5.0119d0,6.3096d0,7.9433d0, &
!                10.0000d0,12.5893d0,15.8489d0,19.9526d0,25.1189d0, &
!                31.6228d0,39.8107d0,50.1187d0,63.0957d0,79.4328d0,100.0000d0], &
!                'pt34_fine')
!          histos(2) = plot_setup_uniform(0.0_dp,60._dp,1.0_dp,'pt34')
!          histos(3) = plot_setup_custom([0d0,2d0,4d0,6d0,8d0, &
!              10d0,12d0,14d0,16d0,18d0,20d0,22.5d0,25d0,27.5d0,30d0, &
!              33d0,36d0,39d0,42d0,45d0,48d0,51d0,54d0,57d0,61d0,65d0, &
!              70d0,75d0,80d0,85d0,95d0,105d0,125d0,150d0,175d0,200d0, &
!              250d0,300d0,350d0,400d0,470d0,550d0,650d0,900d0],'pt34_atlas')
!          histos(4) = plot_setup_custom([0d0,0.004d0,0.008d0,0.012d0, &
!              0.016d0,0.02d0,0.024d0,0.029d0,0.034d0,0.039d0,0.045d0, &
!              0.051d0,0.057d0,0.064d0,0.072d0,0.081d0,0.091d0,0.102d0, &
!              0.114d0,0.128d0,0.145d0,0.165d0,0.189d0,0.219d0,0.258d0, &
!              0.312d0,0.391d0,0.524d0,0.695d0,0.918d0,1.153d0,1.496d0, &
!              1.947d0,2.522d0,3.277d0,5d0,10d0],'phistar_atlas')
!
!          histos(5) = plot_setup_custom([0d0,1d0,2d0,3d0,4d0,5d0,6d0,7d0, &
!              8d0,9d0,10d0,11d0,12d0,13d0,14d0,16d0,18d0,20d0,22d0,25d0, &
!              28d0,32d0,37d0,43d0,52d0,65d0,85d0,120d0,160d0,190d0,220d0, &
!              250d0,300d0,400d0,500d0,800d0,1650d0],'pt34_cms13')
!
!          histos(6) = plot_setup_custom([0d0,2.5d0,5d0,7.5d0,10d0,12.5d0, &
!              15d0,17.5d0,20d0,30d0,40d0,50d0,70d0,90d0,110d0,150d0,190d0, &
!              250d0, 600d0], 'pt34_cms7')
!
!          histos(7) = plot_setup_custom([0d0,2d0,4d0,8d0,10d0,12d0,14d0, &
!              16d0,18d0,20d0,22d0,24d0], 'y34')

        ! mll bins, negative when costheta is negative
        histos(1) = plot_setup_custom([-12000d0,-11800d0,-11600d0,-11400d0, &
                -11200d0,-11000d0,-10800d0,-10700d0,-10600d0,-10500d0,-10400d0, &
                -10300d0,-10250d0,-10210d0,-10180d0,-10150d0,-10120d0,-10100d0, &
                -10080d0,-10060d0,-10050d0,-10040d0,-10030d0,-10020d0,-10015d0, &
                -10010d0,-10005d0,-10001d0,-9999d0,-9995d0,-9990d0,-9985d0, &
                -9980d0,-9970d0,-9960d0,-9950d0,-9940d0,-9920d0,-9900d0,-9880d0, &
                -9850d0,-9820d0,-9790d0,-9750d0,-9700d0,-9600d0,-9500d0,-9400d0, &
                -9300d0,-9200d0,-9100d0,-9000d0,-8800d0,-8600d0,-8400d0,-8200d0, &
                -8000d0,-7750d0,-7500d0,0d0,7500d0,7750d0,8000d0,8200d0,8400d0, &
                8600d0,8800d0,9000d0,9100d0,9200d0,9300d0,9400d0,9500d0,9600d0, &
                9700d0,9750d0,9790d0,9820d0,9850d0,9880d0,9900d0,9920d0,9940d0, &
                9950d0,9960d0,9970d0,9980d0,9985d0,9990d0,9995d0,9999d0,10001d0, &
                10005d0,10010d0,10015d0,10020d0,10030d0,10040d0,10050d0,10060d0, &
                10080d0,10100d0,10120d0,10150d0,10180d0,10210d0,10250d0,10300d0, &
                10400d0,10500d0,10600d0,10700d0,10800d0,11000d0,11200d0,11400d0, &
                11600d0,11800d0,12000d0],'mllafb')

!        histos(2) = plot_setup_custom([0d0,1d0,2d0,3d0,4d0,5d0,6d0,7d0, &
!                8d0,9d0,10d0,11d0,12d0,13d0,14d0,16d0,18d0,20d0,22d0, &
!                25d0,28d0,32d0,37d0,43d0,52d0,65d0,75d0,85d0,100d0,120d0, &
!                140d0,160d0,190d0,220d0,250d0,300d0,350d0,400d0,450d0, &
!                500d0,550d0,600d0,650d0,700d0,750d0,800d0,900d0,1000d0, &
!                1100d0,1200d0,1400d0,1650d0],'pt34')

!        histos(3) = plot_setup_uniform(0.0d0,1.2d0,0.04d0,'y34')

!        histos(4) = plot_setup_uniform(-1.0d0,1.0d0,0.05d0,'costheta')

!        histos(5) = plot_setup_uniform(0.0d0,4.0d0,0.1d0,'eta3')

        ! less fine mll distribution for SM Z plotting
        histos(2) = plot_setup_custom([-12000d0,-11500d0,-11000d0,-10500d0, &
                -10000d0,-9500d0,-9000d0,-8500d0,-8000d0,-7500d0,0d0,7500d0, &
                8000d0,8500d0,9000d0,9500d0,10000d0,10500d0,11000d0,11500d0, &
                12000d0],'mllcrude')

      end subroutine

      subroutine book(p,wt,ids,vals,wts)
          use types
          use ResummationTransition
          use ieee_arithmetic
          implicit none
          include 'src/Inc/mxpart.f'
          include 'src/Inc/kpart.f'
          include 'src/Inc/taucut.f' ! abovecut

          real(dp), intent(in) :: p(mxpart,4)
          real(dp), intent(in) :: wt

          integer, allocatable, intent(out) :: ids(:)
          real(dp), allocatable, intent(out) :: vals(:)
          real(dp), allocatable, intent(out) :: wts(:)

          real(dp) :: pt,pttwo, twomass, delphi, etarap, yrap, yraptwo

          real(dp) :: pt34, trans
          real(dp) :: phistar, phiacop, costhetastar, delphi34
          real(dp) :: y34
          real(dp) :: m34,afb,costheta,eta3

          pt34 = pttwo(3,4,p)
          y34 = yraptwo(3,4,p)
          m34 = twomass(3,4,p)
          eta3 = etarap(3,p)

          delphi34 = delphi(p(3,:),p(4,:))
          phiacop = 2._dp*atan(sqrt((1._dp+cos(delphi34))/(1._dp-cos(delphi34))))
          costhetastar = tanh((etarap(3,p)-etarap(4,p))/2._dp)
          phistar = tan(phiacop/2._dp)*sin(acos(costhetastar))

          costheta = 1.0d0/(m34*sqrt(m34**2d0+pt34**2d0))*((p(3,4)+p(3,3))*(p(4,4)-p(4,3))-(p(3,4)-p(3,3))*(p(4,4)+p(4,3)))
          afb = m34*abs(costheta)/costheta

          if (origKpart == kresummed) then
              if (abovecut .eqv. .false.) then
                  trans = transition((pt34/twomass(3,4,p))**2d0,0.001d0,transitionSwitch,0.001d0)
              else
                  ! fo piece without transition
                  trans = 1._dp
              endif
          else
              trans = 1._dp
          endif

          if (ieee_is_nan(pt34)) then
              pt34 = -1._dp
          endif

          if (ieee_is_nan(phistar)) then
              phistar = -1._dp
          endif

          ids = histos
          vals = [afb,afb]
          wts = [wt*trans,wt*trans]

      end subroutine

end module
