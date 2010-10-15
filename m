Content-Type: multipart/mixed; boundary="===============3375910356317338764=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: Call Barring and MMI Supplementary Service codes
Date: Fri, 15 Oct 2010 14:03:41 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702B20366@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934C889456@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3375910356317338764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Fred,

>As per the 3GPP 22.030 Annex C:
>- the MMI Service Code "22" refers to "All sync services" telecommunicatio=
n service.
>- the MMI Service Code "24" refers to "All data circuit sync" telecommunic=
ation service.
>
>They are both linked to the same Basic Group Service 8.
>So as per our understanding, this means the "All sync services" is equal t=
o "All data circuit sync". Is that everyone's
>comprehension as well?

Yes & No. Previously (Before Rel99, Refer GSM 02.02 and GSM 02.30) we had t=
he the bearer services "All dedicated PAD access" (BSG Number 9, MMI 27) an=
d "All dedicated packet access" (BSG Number 10, MMI 26). In this "All dedic=
ated PAD access" is an asynchronous connection and "All dedicated packet ac=
cess" is a synchronous connection.

So "All Sync Services" used to be =3D> "All data circuit sync" + "All dedic=
ated packet access"
Now that bearer service "All dedicated packet access" is not supported, "Al=
l Sync Services" =3D> only "All data circuit sync" =


>When we try to run Call Barring certification tests (particularly 31.8.3.1=
 from 3GPP 51.010), the spec requires us to =

>activate the call barring with the MMI code "22".
>We do it using org.ofono.SupplementaryServices.Initiate with the following=
 string "*33*1234*22#" (This is the activation =

>of BAOC with password "1234" on All Sync Services), Ofono then sends to th=
e modem the following AT command: AT+CLCK=3D"
>AO",1,"1234",16
>
>According to the 3GPP 27.007 =C2=A77.4 (CLCK), 16 is "data circuit sync".
>So modem will translate that into "all data circuit sync" in the REGISTER =
message sent to the network simulator.
>However according to 3GPP 51.010 31.8.3.1, only a REGISTER message contain=
ing "All synchronous services" is awaited. So =

>conformance  scripts will consider the test as FAILED.
>We noticed the test would be PASS only if CLCK classx parameter was 80 (in=
stead of 16). 80 =3D 16 (data circuit sync) + 64 =

>(dedicated packet access).

As the AT command specification 27.007 still has values for dedicated packe=
t access (64) and dedicated PAD access (128),
in the AT modem case for "All Sync Services" we have to translate to "All d=
ata circuit sync" (16) + "All dedicated packet access" (64) not only to "Al=
l data circuit sync" (16), otherwise as you pointed out the corresponding c=
onformance test case will fail. Thats the reason the test case passes when =
you pass 80.

>Shouldn't we translate the "*33*1234*22#" MMI SS String into AT+CLCK=3D"AO=
",1,"1234",80 ?

From my understanding YES.

BR,
Rajesh

--===============3375910356317338764==--

