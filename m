Content-Type: multipart/mixed; boundary="===============4662805693202921383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA modems and oFono
Date: Sat, 05 Nov 2011 06:39:51 -0500
Message-ID: <4EB52087.3040104@gmail.com>
In-Reply-To: <4EB9860C.8020400@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4662805693202921383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> =

> Looking to the R-UIM 3GPP2 specification (C.S0023), we can understand
> indeed that R-UIM can be considered as an extension of SIM.
> In practice, we can retrieve the same information as for SIM, based
> obviously on different file ids (Emergency codes, preferred language,
> service table, etc...)
> =

> So far, we could imagine to extend the SIM atom to support also R-UIM
> architecture but what could be the purpose of this extension?
> Here, the UIM atom is introduced originally to collect a subscriber
> identifier (MIN or True IMSI) in order to identify uniquely the
> cdma-connman interface.
> But you seems to look for a more global solution. Are we looking to
> support also cdma for voice? cdma for card application tool kit?
> =


Of course we do.  We want a fully functional CDMA stack at some point,
with support for UIM, STK, voice, etc.  This is the reason why we
defined the voice APIs for CDMA so early.

While I'm not completely certain about using a unified Sim atom (CDMA
experts feel free to chime in), I think fundamentally CDMA/GSM are very
similar.  As you mention it is a matter of reading different EFs, while
CHV/PIN handling, BDN, FDN, etc are the same.

So ideally I'd like to figure out what parts are common, what parts are
different and how do these parts overlap.  For example, the EFecc file
is read by the voicecall atom in GSM.  The CDMA equivalent EFecc can be
read by the cdma-voicecall atom, hence there's no real work to unify these.

If it is not infeasible to unify these, then that is what I would like
to do.  Same goes for other atoms that might be similar enough, e.g.
Phonebook.

> Now, if we just need to collect this CDMA subscriber identifier, I think
> also excessive to introduce a specific atom for that.
> =


Sure, but unfortunately that is not the only thing you need.  Think
about pin entry, puk entry, pin lock, unlock, retries, pin2 handling.
Maybe you can get by without these, but then the user has to know all of
these details; definitely not an attribute of a quality product ;)

Regards,
-Denis

--===============4662805693202921383==--

