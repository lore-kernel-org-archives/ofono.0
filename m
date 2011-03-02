Content-Type: multipart/mixed; boundary="===============7529334502870748292=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFCv3] doc: Proposal for LTE/IMS API
Date: Wed, 02 Mar 2011 13:18:12 +0200
Message-ID: <4D6E2774.4000803@nokia.com>
In-Reply-To: <1297377234-5056-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7529334502870748292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur

> +
> +		boolean VoiceOverPs [readonly]
> +
> +			IMS voice is enabled by network
> +			Related AT command: AT+CIREP.
> +
> +		string CsHandoverProgress [readonly, optional]
> +
> +			Indicates the handover progress status during a CS
> +			fallback procedure. The possible values are:
> +				"started"  - CS Fallback procedure has started
> +				"complete" - CS Fallback procedure has completed
> +				"failure"  - CS Fallback has failed
> +				"idle"     - No CS call or fallback is ongoing
> +
> +			Related AT URC: +CIREP
> +

+CIREP reports SRVCC and IMSVOPS events (27.007). As per 23.216, SRVCC =

is basically a handover of CS voice call anchored in IMS to CS domain.

But the property values for csHandoverProgress descriptions says "CS =

Fall back procedure", which i think is wrong. How about changing "CS =

Fallback" to "PS-CS SRVCC Handover"

CS fall back and SRVCC are not the same, to my understanding.  For SRVCC =

the call should be based in IMS and it is a handover, and CSFB happens =

not during call, but before it.

Correct me if i am wrong.

regards
Arun


--===============7529334502870748292==--

