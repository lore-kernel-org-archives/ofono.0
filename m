Content-Type: multipart/mixed; boundary="===============5454632334947874125=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 15:28:11 +0100
Message-ID: <1295360891.3873.179.camel@aeonflux>
In-Reply-To: <1295356747-29758-4-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5454632334947874125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

<snip>

> +				"auto"         Network registration is performed
> +				               automatically.
> +				"forced-auto"  Network registration is performed
> +					       automatically while manual
> +				               selection is disabled.

we need to discuss this a little bit. I am not sure using a mode of
forced auto is the best choice here.

Maybe an extra property like "ManualAllowed" would be better. Thoughts?

Regards

Marcel



--===============5454632334947874125==--

