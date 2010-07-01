Content-Type: multipart/mixed; boundary="===============4782155103746088984=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Voicecall gaps.
Date: Thu, 01 Jul 2010 09:52:09 -0500
Message-ID: <4C2CAB99.5020709@gmail.com>
In-Reply-To: <1277902861-6494-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4782155103746088984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/30/2010 08:01 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi<Pekka.Pessi@nokia.com>
>
> Missing voicecall functionality pieces from tp-ring point-of-view.
> ---
>   TODO |   27 +++++++++++++++++++++++++++
>   1 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/TODO b/TODO
> index 470d4a6..e6ef20d 100644
> --- a/TODO
> +++ b/TODO
> @@ -265,6 +265,33 @@ Supplementary Services
>     Complexity: C8
>
>
> +Voicecall
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Supplementary service notifications for remote party putting call on h=
old
> +  or retrieving the call or joining call to a multiparty conference.
> +
> +  Priority: Medium
> +  Complexity: C1
> +  Owner: Pekka Pessi<pekka.pessi@nokia.com>

Is this in any way related to the present ssn atom?  If it is, then you =

might want to mention this in a bit more detail here.  And are you sure =

this is a C1 task?  Considering the API changes involved, I doubt this =

is a C1 task.

> +
> +- Dial strings. Include CLIR prefixes and 2nd stage dial strings in call=
 history.
> +
> +  Priority: Medium
> +  Complexity: C2
> +
> +- Start DTMF, Stop DTMF, feedback of sent DTMF tones.
> +
> +  Priority: Medium
> +  Complexity: C2

In general if a task is of lower complexity (e.g. C1 or C2) I'd really =

like a short description of the proposed solution in the task overview. =

  In the above two cases I'm really curious how you will manage to do =

this, in particular since AT commands do not support starting / stopping =

DTMF tones.

Please include a short strategy description or increase the complexity.

> +
> +- Add atom for assisting in local supervisory tone generation when modem
> +  does include tones in media streams.
> +
> +  Priority: Medium
> +  Complexity: C2
> +
> +

Please hold off on this one, I'm really not convinced this belongs in =

oFono just yet.

Regards,
-Denis

--===============4782155103746088984==--

