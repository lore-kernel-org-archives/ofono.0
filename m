Content-Type: multipart/mixed; boundary="===============0143038685207931711=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 11:52:04 -0600
Message-ID: <53176444.1040301@gmail.com>
In-Reply-To: <531760EF.6040203@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0143038685207931711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

 > A couple of examples.
>
> Suppose, we have a UI that allows the user to switch between "Automatic"
> and "Custom" MMS or GPRS settings. One of the ways to implement that
> would be to create a new context marked as "manual" and allow the user
> to edit it. The old context remains but it's marked as "automatic" or
> whatever. Manual context has a precedence over the automatic one.
> Switching back to automatic means destroying the "manual" context or
> marking it as "disabled". All that stuff gets saved to the ofono
> SIM-specific gprs file so that these context properties don't get lost
> after swapping SIMs.

That sounds awful from a user perspective.  I don't see why you need to =

store these attributes inside oFono.  Just let the user edit the =

existing context and re-run your provisioning application when the user =

makes the decision to switch back to 'automatic'.  Or better yet, get a =

decent provisioning database so that the user isn't asked for this at all.

>
> Suppose, we have a different connection management system, which shows
> the entire list of available access points to the user and allows to
> choose which one to use. The selected context needs to be marked as
> "default" or something. Again, this context property needs to survive
> SIM swap. With a custom context property that's pretty easy to do.

Feel free to suggest something, maybe a Priority attribute.  But then =

again, a better provisioning database or a dedicated provisioning UI =

would be way nicer from a user perspective.

>
> Every project may have requirements that are more or less unique, often
> influenced by the UI design. There's no need to push support for unique
> project specific requirements into the common code, there's nothing here
> to argue about. It's a matter of whether you want to make ofono a bit
> more usable as is or you are fine with it being cloned and heavily
> modified for each particular project.
>

Knock yourself out then :)

Regards,
-Denis


--===============0143038685207931711==--

