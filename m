Content-Type: multipart/mixed; boundary="===============6795930169687802957=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] provision: allow duplicate apn's from mbpi
Date: Wed, 02 Jan 2019 12:36:59 -0600
Message-ID: <f0ac37c3-3fcd-829d-fba2-e82d98ffaeb3@gmail.com>
In-Reply-To: <20190102115053.79191-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6795930169687802957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/02/2019 05:50 AM, Martin Hundeb=C3=B8ll wrote:
> Let the user/connection-manager decide what to do with duplicate apn
> entries instead of bailing out with an error.
> ---
>   plugins/provision.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

While seemingly trivial, this actually has a huge impact on user =

experience.  The problem is that there's no good meta-data for the user =

to make the decision as to which service is the one they want.

Also, I'm not sure how this impacts connman?  In theory it is supposed =

to auto-activate the internet context, and if there are multiple one of =

these, I'm not sure if it gets confused?

The typical guidance is that if a database contains potential =

duplicates, then a UI Wizard is needed to guide the user to choose the =

appropriate one and provision the context that way.

Alternatively, provide a provisioning database without conflicts, =

perhaps specific to the users / operators you're targeting.

Regards,
-Denis

--===============6795930169687802957==--

