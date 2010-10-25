Content-Type: multipart/mixed; boundary="===============7823258859013152633=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Call counters proposal (TODO patch)
Date: Mon, 25 Oct 2010 16:24:58 +0200
Message-ID: <1288016698.3613.2.camel@aeonflux>
In-Reply-To: <4CC57FE8.3030009@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7823258859013152633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> I am proposing adding Call counters to Voicecall. Here is the TODO patch:
> =

> diff --git a/TODO b/TODO
> index d9a6580..89e180c 100644
> --- a/TODO
> +++ b/TODO
> @@ -329,6 +329,15 @@ Voicecall
>     Complexity: C2
>     Owner: Pekka Pessi <pekka.pessi@nokia.com>
> =

> +- Call counters. Provide total outgoing and incoming call duration =

> information.
> +  Separate call counters will be maintained for each SIM card. Call =

> counters
> +  can be read and reset to 0, and must be backed up periodically to a
> +  non-volatile storage place.

what is wrong with using the history plugin API and working towards a
bridge to get these information into tracker.

I did propose to use obexd for this task since it already has to handle
call history for PBAP anyway and it has a different backends already. So
if you don't wanna use tracker you can use EDS or others.

Regards

Marcel



--===============7823258859013152633==--

