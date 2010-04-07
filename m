Content-Type: multipart/mixed; boundary="===============0139023480363389592=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 10:50:27 +0200
Message-ID: <4BBC4753.6050105@djdas.net>
In-Reply-To: <201004061256.46026.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0139023480363389592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> Hi Dario,
>
>   =

>> +#define SQL_HISTORY_DB_PATH STORAGEDIR "/ofono_history.sqlite"
>> +#define SQL_HISTORY_DB_SQL STORAGEDIR "/oFono_History_DB.sql"
>>     =

>
> So I have my concerns about storing this in /.  This should be in a prope=
r =

> directory, like /var/lib/ofono or something like that.
>
>   =

STORAGEDIR is a macro expanded by Autoconf to ${storagedir} (please see =

rows 172-178 of configure.ac) which is normally /var/lib/ofono so the DB =

and the scripts are already stored inside that dir.
> So remember that the history plugin is instantiated for each and every mo=
dem, =

> so you will be sqlite_open/sqlite_closing the db in each instance.  Not r=
eally =

> sure if this is what you want, or whether you want a reference-counted =

> database connection here.
>   =

Database connection is handled by sqlite3_* API in a transparent manner =

so you could have different open connections at the same time without =

any problem, each SQL statement is transactional so the DB is every time =

consistent, but if you prefer I can rethink of it (maybe a DB for every =

modem could be a possibility but this would overload the plugin because =

we have to open and close the DB in every callback given that we have to =

filter the files access by modem).
> Another thing to consider is that you might want to store the IMSI of the =

> modem along with the history information for every call / sms event.  Tha=
t way =

> when a SIM card is changed, the user can be shown a different set of call=
 / sms  =

> history.
>
>   =

Thank you for this suggestion, didn't think about this :) I have one =

question: what's the best way to get that info?
I see only one function to get the imsi information: const char =

*ofono_sim_get_imsi(struct ofono_sim *sim) which needs a struct =

ofono_sim pointer, but I don't have it in history as it's a member of =

the struct ofono_modem which is blind for me. Can you please point me at =

the function to achieve this?
> Finally, you might want to set limits on the number of entries in the =

> database, and expire them as the limit is reached.   Otherwise you'd need=
 to =

> expire them periodically from e.g. cron, but would need to release contro=
l of =

> the database during that time.
>
>   =

Well this is a more complex topic because needs to point at the purpose =

of the history plugins (in general); I thought at the plugin as a simple =

"event logger" in which an "event" could be a call or a SMS; the =

question is: must the plugin handle all the logic and possibly interface =

with the applications (for example using DBus methods/signals) or is it =

only a mere storage daemon letting applications handle the informations?
Talking about this with one of my team members (Nicola.mfb, which should =

explain better than me applications point of view in a next email) we =

arrived at the conclusion that the history plugin should be able to talk =

directly to the applications (tipically sending DBus signals and =

exporting methods) to mask the storage type of the history data.
Also in this case there could be some possible issues to handle: who is =

aware of the msg_id? Only the plugin or even the application? In the =

former case must the application provide to the plugin its own msg_id to =

recover SMS data?
Another question is: what if we had different history plugins at the =

same time, like an EDS one, a plain text one, a Berkley DB one and an =

SQLite one? There should be only one plugin active per ofonod instance =

or per modem? In case different plugins are active at the same time, the =

"history DBus interface" is global for all the plugins (i.e. a method to =

delete an incoming sms from modem /modem0 with msg_id =3D 123 must delete =

it on all backends?) or each plugin has its own?
Thank you very much in advance, best regards,
Dario

--===============0139023480363389592==--

