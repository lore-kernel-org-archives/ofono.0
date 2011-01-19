Content-Type: multipart/mixed; boundary="===============5131322710166040861=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-auth RFCv2 2/4] Added doc/sim-authentication-api.txt.
Date: Tue, 18 Jan 2011 21:34:51 -0600
Message-ID: <4D365BDB.7020109@gmail.com>
In-Reply-To: <1294873702-10316-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5131322710166040861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/12/2011 05:08 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> The authentication mechanisms include SIM authentication (basic A8
> authentication used with GSM), AKA authentication and UICC-based GBA
> authentication.
> =

> The SIM and AKA can be used to implement EAP and GBA authentication
> algorithms.
> =

> The interface can be applied to both SIM/USIM or ISIMs.

So I think this is a great start, but the entirety of this proposal
might be too much (at least for me) to digest all at once.  So my vote
would be that we start with the simplest SIM authentication mechanism
and implement it first.  We can mark the API as experimental during this
time.  Then add additional mechanisms as we gain better understanding /
have time to read the specs.

Specifically I'd like to see the flow from the core atom to the AT / ISI
modem.

Regards,
-Denis

--===============5131322710166040861==--

