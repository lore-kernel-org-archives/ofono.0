Content-Type: multipart/mixed; boundary="===============7066151896224526371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] gatchat: implement timeout setting for commands
Date: Mon, 02 Sep 2019 16:25:01 -0500
Message-ID: <0035204a-e272-92cd-d59a-e252299dffef@gmail.com>
In-Reply-To: <20190902211011.61386-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7066151896224526371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/2/19 4:10 PM, Martin Hundeb=C3=B8ll wrote:
> The adds a function to the set a chat-wide timeout for at commands. It
> allows plugins to handle cases where the modem fails to respond with
> either an OK or an error.

Okay, this is sort of a known problem without a really good solution...

> =

> Without these timeouts, the plugin is never notified about a hanging
> command, and it has no way to detect it; effectively leaving the device
> in a broken state, where only a full restart of the ofono service
> unbreaks it.

The trouble is, what if this happens on a command handled by a generic =

atmodem driver atom?  Are you going in and adding timeout handling to =

all command callbacks?

If this timeout only happens in special cases, then those can be taken =

care of by setting up your own timeout...

> =

> If a timeout occurs, the passed callback is invoked with 'ok' set to
> false, and no final response in the result. This allows callbacks to
> identify the timeout with this snippet:
> =

>    if (!ok) {
>      decode_at_error(&error, g_at_result_final_response(result));
>      if (error.type =3D=3D OFONO_ERROR_TYPE_FAILURE) {
>        /* handle timeout */
>      }
>    }

About the only thing I can suggest is to create a separate timeout =

callback for the GAtChat object that the modem driver can set.  That way =

if the timeout happens, the modem driver can just reset the entire =

setup.  E.g. maybe via ofono_modem_reset.

> ---
>   gatchat/gatchat.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>   gatchat/gatchat.h |  9 +++++++
>   plugins/quectel.c |  3 ---

Also, I guess this part was extraneous :)

>   3 files changed, 69 insertions(+), 3 deletions(-)
> =


Regards,
-Denis

--===============7066151896224526371==--

