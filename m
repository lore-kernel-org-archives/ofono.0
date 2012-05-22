Content-Type: multipart/mixed; boundary="===============4533495815484307390=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 3/3] doc: Add new D-Bus methods to service interface
Date: Tue, 22 May 2012 10:22:30 -0300
Message-ID: <CAMOw1v7m-RrXE26cA0ggdT3VW3mF8XbJkuGYu8Zd2Ak64X7-wA@mail.gmail.com>
In-Reply-To: <1337615963-9443-4-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4533495815484307390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 12:59 PM, Ronald Tessier
<ronald.tessier@linux.intel.com> wrote:
> ---
> =C2=A0doc/service-api.txt | =C2=A0 20 ++++++++++++++++++++
> =C2=A01 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/doc/service-api.txt b/doc/service-api.txt
> index 36e1161..02396ff 100644
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -63,6 +63,26 @@ Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0array{object,dict} GetMessages()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[service].Error.PermanentContentNotAc=
cepted
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[service].Error.PermanentLackOfPrepaid
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void DeleteMessages(ar=
ray{object})
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Delete an array of message objects that represents
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 the currently stored messages to delete.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Possible Errors: [service].Error.InvalidArguments
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void DeleteConversatio=
n(string number)


Could we mark these as [TODO], so we don't  get confused while reading
the doc + code and realizing they don't match?


Lucas De Marchi

--===============4533495815484307390==--

