Content-Type: multipart/mixed; boundary="===============5677235868034858337=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Tue, 01 Feb 2011 22:25:30 +0200
Message-ID: <1296591930.2619.60.camel@tucson>
In-Reply-To: <4D46C032.60405@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5677235868034858337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paavo,

On Mon, 2011-01-31 at 15:59 +0200, ext Paavo Leinonen wrote:
> Could it be possible to extend current TechnologyPreference setting in
> radio-settings-api in a way which would enable user to limit usage of =

> certain
> radio accesses? For example user could choose to limit technology usage to
> technologies like GSM and UMTS even if the LTE coverage would be availabl=
e.
> Following value could be introduced to current API to enable this kind of
> selection:
> =

> "gsm"      Only GSM used for radio access.
> "umts"     Only UMTS used for radio access.
> "gsm_umts" Only GSM or UMTS used for radio access.
> "lte"      Only LTE used for radio access.

The current API has 'gsm', 'umts', 'lte' and 'any'. I think you are
suggesting something like 'all-but-lte', right?

> Other approach could be that we would rephrase existing API so that =

> instead of
> using "only" LTE, we would use LTE whenever available and some older =

> technology
> when LTE coverage is lacking. So user would select "highest" allowed radio
> access without restrictions to use only one technology which has been =

> selected.

This is what 'any' essentially is for.

> This would save us from polluting value selection with options like =

> "gsm_umts",
> a decision we'd be grateful when we'll run oFono on 10G modems. ;)
> =

> Use case for this could be energy conservation. At least I have habit to =
set
> network preference to 'GSM' to conserve battery life when I know I'm =

> going to
> travel places where 3G coverage is not that good or I'm not going to =

> need it.

I think this will also get gradually better as networks and handsets are
upgraded to use better power saving features, such as CPC.

Cheers,
Aki

> Br,
> Paavo
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono




--===============5677235868034858337==--

