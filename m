Content-Type: multipart/mixed; boundary="===============6106061821097567758=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH v2 5/7] text-telephony: add documentation
Date: Thu, 25 Nov 2010 10:53:55 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D068C18E@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1290535458-18786-6-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6106061821097567758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23 Nov 2010, Lucas De Marchi wrote:
> +Interface	org.ofono.TextTelephony
[...]
> +Properties	boolean	Powered [readwrite]
> +
> +			This property will enable or disable the text
> +			telephony feature in the modem.
> +
> +			Text telephony (TTY), also known as TDD, is a feature
> +			present in some modems that allow them to be used by
> +			hearing impaired people.

just to clarify, I guess this covers all aspects of TTY
support handled by the modem? =


E.g. for modems, TTY/CTM support can mean:
- signaling TTY/CTM support as a capability (e.g. in Bearer Capability =

  of 24.008 at the start of calls) ->all modems that support TTY
  do this
- above plus: performing CTM coding on modem ->some modems
- above plus: handling audio input/output  ->some modems

So depending on the modem, enabling TTY with this new oFono =

interface enables all of the above (those the apply), right? =


This makes sense as AFAIK there is no need to control the different
aspects separately (and is analogous to handling voice calls
in general with oFono), but just making sure I understand =

the semantics correctly.

If in the future ofono clients need more information about the speech =

data path processing (w.r.t. TTY), that can be then added to
org.ofono.AudioSettings interface (e.g. whether modem does =

CTM coding, whether it supports HCO/VCO (does voice go through
at all when TTY mode is enabled). But until we have a modem (and
use case) that needs this, it's too early to add these. E.g. Nokia =

N900 does not support TTY, but if the support was added, in theory =

it could technically do CTM coding both on modem and/or on Linux =

side.

br,
-- =

Kai Vehmanen


--===============6106061821097567758==--

