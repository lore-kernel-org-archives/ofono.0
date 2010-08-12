Content-Type: multipart/mixed; boundary="===============3379940659177514000=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Startup sequence for Online / offline mode
Date: Thu, 12 Aug 2010 12:37:29 -0500
Message-ID: <4C643159.7070409@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90111C20B21@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3379940659177514000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

On 08/12/2010 12:23 PM, Bastian, Waldo wrote:
> Modem drivers that support Online / offline mode default to offline when
> oFono loads them. Which component is responsible for calling oFono and
> switch the modem to online mode? Will that component be part of MeeGo?

This feature is still highly experimental and not all of the details
have been figured out (only ISI supports it today).

Our current thinking is to have ConnMan manage the Online state of the
GSM modems (e.g. replace Powered handling with Online handling.)
However, we're still pretty far from that; we'd need to migrate all
existing modem drivers to manage Online/Offline state properly first.

Regards,
-Denis

--===============3379940659177514000==--

