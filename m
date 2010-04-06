Content-Type: multipart/mixed; boundary="===============6160960906959729848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Tue, 06 Apr 2010 12:56:45 -0500
Message-ID: <201004061256.46026.denkenz@gmail.com>
In-Reply-To: <4BBB104F.2090604@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6160960906959729848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> +#define SQL_HISTORY_DB_PATH STORAGEDIR "/ofono_history.sqlite"
> +#define SQL_HISTORY_DB_SQL STORAGEDIR "/oFono_History_DB.sql"

So I have my concerns about storing this in /.  This should be in a proper =

directory, like /var/lib/ofono or something like that.

> +static int sqlite_history_probe(struct ofono_history_context *context)
> +{
> +	char *execerror;
> +
> +	ofono_debug("SQLite History Probe for modem: %p", context->modem);
> +
> +	if (sqlite3_open(SQL_HISTORY_DB_PATH, &db) !=3D SQLITE_OK) {
> +		ofono_debug("Error opening DB: %s", sqlite3_errmsg(db));

Please use DBG macro instead of ofono_debug.

> +		sqlite3_close(db);
> +		return -1;
> +	}
> +
> +	if (sqlite3_exec(db, SELECT_CALLS, NULL, NULL, &execerror) !=3D SQLITE_=
OK)
>  { +		char *sqlscript;

Should be

if (sqlite3_exec =3D=3D SQLITE_OK)
	return 0;

Then the rest of the if statement follows unnested.
> +		GError *sqlerror =3D NULL;
> +
> +		ofono_debug("Creating DB");
> +
> +		g_file_get_contents(SQL_HISTORY_DB_SQL, &sqlscript, NULL, &sqlerror);
> +
> +		if (sqlerror !=3D NULL) {
> +			ofono_debug("Error opening sql script: %s", sqlerror->message);
> +			g_error_free(sqlerror);
> +			return -1;
> +		}
> +
> +		if (sqlite3_exec(db, sqlscript, NULL, NULL, &execerror) !=3D SQLITE_OK=
) {
> +			ofono_debug("Error executing sql script: %s", execerror);
> +			sqlite3_free(execerror);
> +			g_free(sqlscript);
> +			return -1;
> +		}
> +
> +		g_free(sqlscript);
> +	}
> +
> +	return 0;
> +}
> +
> +static void sqlite_history_remove(struct ofono_history_context *context)
> +{
> +	ofono_debug("SQLite History Remove for modem: %p", context->modem);
> +
> +	if (db !=3D NULL)
> +		sqlite3_close(db);
> +}
> +

So remember that the history plugin is instantiated for each and every mode=
m, =

so you will be sqlite_open/sqlite_closing the db in each instance.  Not rea=
lly =

sure if this is what you want, or whether you want a reference-counted =

database connection here.

Another thing to consider is that you might want to store the IMSI of the =

modem along with the history information for every call / sms event.  That =
way =

when a SIM card is changed, the user can be shown a different set of call /=
 sms  =

history.

Finally, you might want to set limits on the number of entries in the =

database, and expire them as the limit is reached.   Otherwise you'd need t=
o =

expire them periodically from e.g. cron, but would need to release control =
of =

the database during that time.

Regards,
-Denis

--===============6160960906959729848==--

