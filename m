Content-Type: multipart/mixed; boundary="===============3966170699556656881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gatserver: Add send raw data function
Date: Mon, 14 Feb 2011 10:23:57 -0600
Message-ID: <4D59571D.1090900@gmail.com>
In-Reply-To: <1297440183-4384-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3966170699556656881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

> @@ -112,6 +112,7 @@ void g_at_server_send_unsolicited(GAtServer *server, =
const char *result);
>   * responses.
>   */
>  void g_at_server_send_info(GAtServer *server, const char *line, gboolean=
 last);
> +void g_at_server_send_data(GAtServer *server, const char *format, ...);
>  =


What is the target use case you're thinking of for this one?

>  #ifdef __cplusplus
>  }

Regards,
-Denis

--===============3966170699556656881==--

