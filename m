Content-Type: multipart/mixed; boundary="===============7330067362209300757=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 3/3] gprs: Use netreg SPN watch API
Date: Fri, 30 Dec 2011 10:43:53 +0200
Message-ID: <4EFD79C9.4090802@intel.com>
In-Reply-To: <4EFB94CA.1000001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7330067362209300757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 12/29/2011 12:14 AM, Denis Kenzior wrote:
> So I like this approach, the only problem is that netreg atom is a
> post_online atom and gprs is post_sim atom.  This means that if no
> contexts are provisioned we must wait for the netreg atom to be
> registered.  This leads to a slight asymmetry in the API.
>
> Perhaps we should move the SPN logic to the sim atom and make netreg and
> gprs atom simple consumers?

Thanks for the review! Yes, moving the SPN logic into the sim atom will ind=
eed =

simplify the logic, I like the idea.

I will prepare another patchset.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============7330067362209300757==--

