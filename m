Content-Type: multipart/mixed; boundary="===============5544709896005025122=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Tue, 13 Aug 2019 08:42:52 +0200
Message-ID: <a3d7b41d-173f-d334-9b7d-cabef2e89de6@norrbonn.se>
In-Reply-To: <CAA=hcWQFVYG_hqhDf--Vu2L-KN6z9nOU_Vb93eEewoaw7opPwg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5544709896005025122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JH,

On 13/08/2019 00:09, JH wrote:
> Hi Jonas,
> =

> Do you have any comments about it?

Sure... there's not much to go on in the logs you've posted, just an =

assertion that the LTE connection was silently dropped.  It would be =

better if you could show the behaviour with more complete debug output:

ofonod -d

The issue could be (perhaps) that there's a QMI message that ofono =

doesn't handle and is silently ignoring... dumping the QMI communication =

might useful:

OFONO_QMI_DEBUG=3D1 ofonod -d


> =

> Thank you.
> =

> Kind regards,
> =

> - jupiter
> =

> On 8/12/19, JH <jupiter.hce@gmail.com> wrote:
>> Hi Giacinto,
>>
>> On 8/11/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
>>
>>> can you check with the ofono script test/list-contexts if the method
>>> is static or dhcp?
>>
>> # ofono/test/list-contexts
>> [ /ubloxqmi_0 ]
>>      [ /ubloxqmi_0/context1 ]
>>          Name =3D Internet
>>          Type =3D internet
>>          AuthenticationMethod =3D chap
>>          Settings =3D { Method=3Dstatic Gateway=3D10.116.103.22
>> Netmask=3D255.255.255.25}

No Address?  No Interface?  Running ofono with debug output will =

probably shed some light on what's going on here.

>>          Username =3D
>>          AccessPointName =3D telstra.m2m
>>          Password =3D
>>          Protocol =3D ip
>>          IPv6.Settings =3D { }
>>          Active =3D 1
>>
>> Looks like it is static, how can change it to a correct one (dynamic
>>> )? Or any workarounds?

static is correct.  ofono configures the local network interface =

appropriately for the established context.

Given that ofono isn't reporting either an address nor interface above, =

I wonder what the network interface has been configured to.  What do 'ip =

link' and 'ip addr' show?


>>
>>> I believe this can be the problem: if ofono managed to get an IP
>>> address, likely with at+cgpaddr and/or at+cgcontrdp,
>>> then it passes it to connman, and then it is set on the interface...
>>> static, with no lease expiration.

I don't think the SARA R4 support DHCP... correct me if I'm wrong.


>>
>> There are two devices for the SARA-R4 modem, /dev/ttyUSB0 is used for
>> QMI which is currently using as default protocol. /dev/ttyUSB1 is for
>> AT,

No, the QMI device is another USB endpoint that presents interfaces in =

two separate Linux subsystems:  one network device and one qmimisc =

device.  The ttyUSB devices are for AT functionality which you won't be =

using if you are using the QMI channel.


  let me know if you like to check AT command, I have never tried to
>> write / read AT command, are the following commands correct?
>>
>> echo "at+cgpaddr" > /dev/ttyUSB1
>> cat < /dev/ttyUSB1

Try using minicom or something similar if you want to play with AT =

commands directly.

/Jonas

>>
>> Thank you very much Giacinto.
>>
>> -- jupiter
>>

--===============5544709896005025122==--

