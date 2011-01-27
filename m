Content-Type: multipart/mixed; boundary="===============0339105842493271732=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC] voicecallmanager-api: call related SS signals (proposal)
Date: Thu, 27 Jan 2011 12:39:25 +0200
Message-ID: <201101271239.25518.remi.denis-courmont@nokia.com>
In-Reply-To: <e514ceea10c7e8eb0f8d556e9764ea4e0c9abe04.1296122953.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0339105842493271732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 27 January 2011 12:20:50 ext Andras Domokos, you wrote:
> Here is a proposal for expanding VoiceCallManager's DBus interface with
> call related Supplementary Services signals.
> The implementation would be based on the functionality provided by the SSN
> atom (handling the CSSU codes).

Is there any reason why forwarded, transferred, CUG and deflected incoming =

calls would not use the existing CallAdded signal? Shouldn't those be facto=
ids =

be visible as properties of the call?

Similarly, I'd rather have the other signals be property changes in of call =

object itself, no?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0339105842493271732==--

