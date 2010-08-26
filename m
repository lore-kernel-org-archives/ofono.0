Content-Type: multipart/mixed; boundary="===============8900064471211426101=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] sim: Read EFsst
Date: Thu, 26 Aug 2010 18:51:59 +0200
Message-ID: <AANLkTinA3XTK_g+Ym1Yv6tD4yyBzFmChs+kHbn=8DiX6@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4732A516D1E@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8900064471211426101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 26 August 2010 12:12, Gu, Yang <yang.gu@intel.com> wrote:
> Last time, you mentioned " 3G device + 3G sim -> EFust and EFest, while 2=
G device + 3G sim -> EFsst". And I think EFphase only means the SIM phase. =
So just using SIM phase to do the judgement would put us in a risk if we ha=
ve a phase 3 SIM and 2G device, right? You also mentioned this is the best =
way we currently have. Do you hint we have no (general) way to get the phas=
e of device?
>
> But I still think there is some problem here: For this case, EFust and EF=
sst have the same file id and type. So I suppose they can't co-exist in the=
 SIM file system. Otherwise, we couldn't read them by just using the file i=
d and file type. If so, and if I were a SIM manufacturer, how should I deci=
de which one, EFust and EFsst, will be put in? I would have no knowledge wh=
at the phase of user's device. So the rule to obey is to have my choice mat=
ch the EFphase. That is, 3G sim -> EFust and 2G sim ->EFsst.

As far as I understand, a 3G SIM can actually have two filesystems.
One of them contains the EFphase, EFsst, and other files, while the
other filesystem contains EFust, EFest and no EFphase (some files will
be the same).  That's why we have separate cache for them.  If a 2G
modem initiates the card as 2G then the card needs to consistently act
as a 2G card.

Regards

--===============8900064471211426101==--

