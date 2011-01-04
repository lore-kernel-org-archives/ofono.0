Content-Type: multipart/mixed; boundary="===============2524560029437107382=="
MIME-Version: 1.0
From: Sullivan, Terrance <Terrance.Sullivan@windriver.com>
Subject: RE: CDMA progress?
Date: Tue, 04 Jan 2011 22:41:58 +0000
Message-ID: <B79FBA42FB1F254B87C0F024D44814E802B182@ALA-MBB.corp.ad.wrs.com>
In-Reply-To: <4D236F02.5080605@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2524560029437107382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Lei for your quick response..

-----On 01/04/2011 01:56 PM Lei Yu wrote-----
> Glad to hear that you have found a modem that supports SMS rx/tx in PDU f=
ormat. Could you pls share more detailed info on that? > We would like to e=
valuate if we can use that as our hardware test platform. Also, looking for=
ward to seeing your contributions > to CDMA support in oFono. The more the =
merrier.

While we now have this Qualcomm device network operational running Meego 1.=
1 with a modified oFono 0.34 branch, we are continuing with its development=
 and merging in more recent oFono changesets into our internal builds. Cons=
equently, we can provide some test feedback but as yet this device is not c=
ommercially available at present. As a result, there are limitations on spe=
cific details that we can provide, for example, proprietary vs. the device'=
s standardized CDMA/GSM command interfaces. However, we will attempt to pro=
vide the details you require around our most recent SMS-PDU implementation =
when we send out our API reference shortly..

That said I can think of several aspects to help address the above and that=
 we may want to discuss here, namely:

1) Since this device has dual radios operating in active/standby mode, the =
use of distinct virtual TTYs for serperate GSM & CDMA signalling that are t=
hen multiplexed into a common physical interface and

2) A "shim" layer within this common physical interface which allows propri=
etary commands to be "externalize" where appropriate while also correctly p=
ropagating dual-mode baseband/radio state back to the oFono stack.

While these aspects are obviously driver specific we think they are interes=
ting to start with as they represent various trends moving forward and we w=
ould value getting people's input..

Regards and I look forward to your response..
Terry



--===============2524560029437107382==--

