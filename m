Content-Type: multipart/mixed; boundary="===============8704573697764348352=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] [RfC] doc: Proposed Set Up Call api.
Date: Wed, 18 Aug 2010 00:32:11 -0500
Message-ID: <4C6B705B.1070400@gmail.com>
In-Reply-To: <1282059423-28864-5-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8704573697764348352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index efeae42..dae3ec2 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -106,3 +106,14 @@ Properties	string LineIdentification [readonly]
>  			stamped when the call enters the "active" state.
>  			Client applications can use this to infer somewhat
>  			reliable call duration information.
> +
> +		string Information [readonly, optional]
> +
> +			Contains information related to the call for the
> +			user.  Currently this property is set for calls
> +			initiated by SIM Toolkit applications.
> +
> +		string IconID [readonly, optional]
> +
> +			Icon identifier to be used instead of or together
> +			with the text information.

So my preference here is simply Icon, or IconIdentifier.  IconID breaks
our pure CamelCase rules for APIs.

Regards,
-Denis

--===============8704573697764348352==--

