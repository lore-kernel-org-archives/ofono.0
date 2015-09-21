Content-Type: multipart/mixed; boundary="===============1482457087658662635=="
MIME-Version: 1.0
From: Pawlak, KubaX T <kubax.t.pawlak@intel.com>
Subject: RE: Hands Free/Pulse - not working well
Date: Mon, 21 Sep 2015 15:12:53 +0000
Message-ID: <088CC8BACB3382439E91D9919CE350243655A218@IRSMSX107.ger.corp.intel.com>
In-Reply-To: <CAHY_EhXkGhQ6DRJn5NEgv6cOwJiwpr0UKHigYq3QDyw=7Yf-0A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1482457087658662635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

> I placed one call, and everything worked (audio in out of the computer). =
I've been able to get this to happen once in a while.
> I disconnect the call from the phone.   I placed a second call, there was=
n't any audio, and my logs scroll like this:
> [ 1052.809382] Bluetooth: hci0 SCO packet for unknown connection handle 2
> [ 1052.809964] Bluetooth: hci0 SCO packet for unknown connection handle 1=
6384
> [ 1052.810563] Bluetooth: hci0 SCO packet for unknown connection handle 48
> [ 1052.811371] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.811982] Bluetooth: hci0 SCO packet for unknown connection handle 2=
56
> [ 1052.812581] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.813378] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.813968] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.814712] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.815681] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.816536] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.817712] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.818544] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.819508] Bluetooth: hci0 SCO packet for unknown connection handle 1
> [ 1052.820332] Bluetooth: hci0 SCO packet for unknown connection handle 1

Messages "SCO packet for unknown connection handle" at SCO creation are pro=
duced when there is an issue in packet reassembly. It basically means that =
the driver failed to assemble USB packet into SCO packets and what is pushe=
d up is not audio but garbage. When this is printed continuously on the con=
sole, it means you are not going to have any audio, until it stops. Most co=
mmon cause is that there is a fragment of SCO packet cached in the driver.
Controller usually fragment packets into 3 parts, that the kernel needs to =
put together and create one SCO packet that is forwarded to upper layers. O=
n connection close a fragment may be left in the driver. When another call =
is established, this fragment is going to be used, and further fragments ar=
e going to be attached to it. You are using kernel 3.16, which has certain =
guards removed (that are in older kernels), that would help the kernel to q=
uickly recover from this issue. =


I've made a patch for this issue. It's already in Bluetooth-next tree and w=
as merged to linux-next. It is not yet in any official kernel. It removes a=
ny leftover fragments that are there between SCO connections.

If you are able to compile you own kernel then add this commit:
http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/co=
mmit/?id=3D8f9d02f470f48416444ac3a1eacecdd0f743f1a7

Also note that SCO handling is a bit buggy in the kernel. I'm now pursuing =
few crashes at SCO creation and disconnection.

Kuba Pawlak
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

--===============1482457087658662635==--

