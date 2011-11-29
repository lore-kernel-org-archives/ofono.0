Content-Type: multipart/mixed; boundary="===============6718352031840328052=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] udev rules update
Date: Tue, 29 Nov 2011 13:20:39 +0100
Message-ID: <1322569239.29909.61.camel@aeonflux>
In-Reply-To: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6718352031840328052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> This set of patches have been sent this summer but not upstreamed.
> As few bugs have been opened which could be fixed by those patches, I res=
end them
> for review.
> =

> - For Speedup dongles, the logic in udevng is to assign the modem port on=
 the
> latest interface. This is not true for SpeedUp SU-7300U (BUG #23168) and =

> SpeedUp 9800 (BUG #23167). So, I added 2 specific rules for both dongles.
> =

> - For dongle ZTE MF190, 6 interfaces are present and we shall use the int=
erface
> ttyUSB4 for modem channel. The logic in udevng is to assign the modem cha=
nnel
> on the latest interface. To not break the support of ZTE modems with 5 =

> interfaces (which are using the 4th one for PPP, like K3570), I can't ext=
end
> the current logic to take into account the ttyUSB4. So, I added a specifi=
c rule
> for ZTE MF190.
> I added also a specific rule for the dongle ZTE MF668 as the modem channe=
l is
> not on the latest interface (BUG #23683)

why is all this reasoning here and not in the commit message of the
patches? I expect that every patch has a proper commit message that
explains its goal. Just a non-meaningful subject line is not enough.

Regards

Marcel



--===============6718352031840328052==--

