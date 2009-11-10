Content-Type: multipart/mixed; boundary="===============7578965723024592405=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: How does ConnMan works with Ofono? RE: [PATCH */4] add interface
 property to primary context
Date: Tue, 10 Nov 2009 11:28:53 +0800
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D8BB5B1FC@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D888EF02E@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7578965723024592405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel/Denis
In order to implement interface property. I think we need to clarify how do=
es ConnMan work with Ofono firstly

In my opinion ConnMan and ofono works like below. Could you review and give=
 out your opinions? Thanks!

PC_i: PrimaryContext_(internet type):
______________________________________
Ofono                         ConnMan
------------------------------------------------------------------

1.Modem                    device
  |
  | (create/load)
  |
  V
2.PC_i                     Network
  |
  |(powered up)
  |
  V
3.Attached PC_i----------->    Service (ready)
                         |
                         |(connect)
                         |
                         V =

4.Activated PC_i           Service (associated)
                         |
                         |(configure/dhcp)
                         |
                         V
5.                       Service (READY)

1. ConnMan detects the Modem from Ofono and create corresponding device
2. ConnMan detects the PC_i and create corresponding Network(First time, Co=
nnMan will ask Ofono to create PC_i)
3. Once the PC_i attached ConnMan will create service
4. When user connects service, ConnMan will ask ofono to activate PC_i.
   When PC_i is activated, Service in ConnMan is associated.
5. ConnMan will configure/dhcp to ipconfigure the service, and then service=
 in READY state

--===============7578965723024592405==--

