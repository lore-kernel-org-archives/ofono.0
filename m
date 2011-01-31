Content-Type: multipart/mixed; boundary="===============5447129569118073902=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Mon, 31 Jan 2011 16:08:05 +0200
Message-ID: <201101311608.05402.remi.denis-courmont@nokia.com>
In-Reply-To: <4D46C032.60405@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5447129569118073902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 31 January 2011 15:59:14 ext Paavo Leinonen, you wrote:
> Hi all,
> =

> Could it be possible to extend current TechnologyPreference setting in
> radio-settings-api in a way which would enable user to limit usage of
> certain radio accesses?

> For example user could choose to limit technology usage to
> technologies like GSM and UMTS even if the LTE coverage would be availabl=
e.
> Following value could be introduced to current API to enable this kind of
> selection:
> =

> "gsm"      Only GSM used for radio access.
> "umts"     Only UMTS used for radio access.
> "gsm_umts" Only GSM or UMTS used for radio access.
> "lte"      Only LTE used for radio access.

Oh my, no.

If you want to control technologies one by one, use a string and a boolean.=
 If =

you really want atomicity w.r.t. D-Bus, then make it a dictionary.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5447129569118073902==--

