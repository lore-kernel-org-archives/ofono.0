Content-Type: multipart/mixed; boundary="===============8023983569077988189=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: Add NetworkRegistration.OperatorsChanged signal
Date: Mon, 12 Jan 2015 23:29:10 -0600
Message-ID: <54B4AD26.2090209@gmail.com>
In-Reply-To: <1420032256-2616-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8023983569077988189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 12/31/2014 07:24 AM, Slava Monich wrote:
> This signal gets emitted when operator list has changed.
> It contains the current list of operators.
> ---
>   doc/network-api.txt |  5 +++++
>   src/network.c       | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 48 insertions(+), 1 deletion(-)
>

Please refer to HACKING, 'Submitting patches' section, item 3.

3) Split your patch according to the top-level directories. E.g.: if you =

added
a feature that touches files under 'include/', 'src/' and 'drivers/'
directories, split in three separated patches, taking care not to
break compilation.

> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index 83a2bc0..d635ba7 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -57,6 +57,11 @@ Signals		PropertyChanged(string property, variant valu=
e)
>   			This signal indicates a changed value of the given
>   			property.
>
> +		OperatorsChanged(array{object,dict})
> +
> +			Signal that gets emitted when operator list has
> +			changed. It contains the current list of operators.
> +

I support the spirit of this change.  However, it is really not =

consistent with the other APIs of this sort.  For example:

Manager.ModemAdded, Manager.ModemRemoved
MessageManager.MessageAdded, MessageManager.MessageRemoved
ConnectionManager.ContextAdded, ConnectionManager.ContextRemoved

The name is also a bit misleading, since certain attribute changes are =

not tracked by update_operator_list...

I think it would be better if we introduced OperatorAdded and =

OperatorRemoved signals instead.

Regards,
-Denis

--===============8023983569077988189==--

