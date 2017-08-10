Content-Type: multipart/mixed; boundary="===============1610836299216297842=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: AW: AW: AW: connmand[186]: Online check failed but running
 dhclient manually fixes this issue
Date: Thu, 10 Aug 2017 11:05:40 +0200
Message-ID: <e2eea629-eb75-420e-1e43-900fccaa21b4@monom.org>
In-Reply-To: <59ea6e9c46df41b3ba756f153c92fb57@FE-MBX1014.de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1610836299216297842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinothkumar,

[sorry for the last mails where I got your last name mixed up...]

On 08/10/2017 07:03 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Could you send me the exact modem description you are using? So that we c=
an write quirk?
> =

> Hi,
> =

> I am using TELIT 910 EUG Modem.

Okay, maybe that is already enough. I saw that in drivers/telit.c there =

is already some code to handle variants of the modem. The matching is =

done on these strings.

Are there any vid/pid available fot his modem?

Thanks,
Daniel

--===============1610836299216297842==--

