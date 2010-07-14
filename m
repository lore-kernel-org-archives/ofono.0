Content-Type: multipart/mixed; boundary="===============8858382445980772924=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/6] emulator: Add ofono_emulator framework
Date: Wed, 14 Jul 2010 09:50:30 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F7EE66D@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C3D1704.1020403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8858382445980772924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> I grabed code from obex to register&start DUN GW service
> when we parse adapter properties. From patch 6/6, you can see
> my current implementation is to find the first powered modem
> that having GRPS atom. Load settings from modem.conf could be
> another option. But what if the modem is detected from udev?
> It could be huawei0, huawei1 or huawei<N>.
> =

> Doing it via .conf file is still possible.  E.g. we might be able to
> stipulate that only modems with a particular driver get exported (e.g.
> driver=3D"huawei" or driver=3D"isi")  Or perhaps a hardcoded path / first
> modem available.  I wouldn't worry about it for now, do whatever is
> easiest.  The more interesting part is getting the oFono core
> emulator bits working. =

> =

> Regards,
> -Denis

Sure. Will update the patches soon.

Regards,
Zhenhua


--===============8858382445980772924==--

