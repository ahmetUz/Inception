# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: auzun <auzun@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/01 03:06:26 by auzun             #+#    #+#              #
#    Updated: 2023/05/01 18:02:46 by auzun            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED				=	$'\e[0;31m
GREEN			=	$'\e[32m
YELLOW			=	$'\e[33m
BOLD			=	$'\e[1m
UNDER			=	$'\e[4m
END				=	$'\e[0m

VOLUMES_PATH	=	/home/auzun/data/mariadb \
					/home/auzun/data/wordpress

all:
					if test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -eq 1; then \
						mkdir -p $(VOLUMES_PATH); \
						echo "$(GREEN) The volumes have been successfully created.$(END)"; \
						sudo docker-compose -f src/docker-compose.yml up -d --build; \
						echo "$(GREEN) All services are ready"; \
						echo " $(BOLD)You can consult the wordpress page using this link -> $(UNDER)auzun.42.fr$(END)"; \
					else \
						echo "$(YELLOW) All services are already build$(END)"; \
					fi

up:
					if test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -eq 1; then \
						echo "$(RED) Containers were not built$(END)"; \
					elif test $$(sudo docker ps | wc -l) -eq 4; then \
						echo "$(RED) All services are already running$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml up -d; \
						echo "$(GREEN) All services are ready$(END)"; \
					fi

stop:
					if test $$(sudo docker ps | wc -l) -eq 1; then \
						echo "$(YELLOW) No container is build or up$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml stop; \
						echo "$(GREEN) All services have been successfully stopped$(END)"; \
					fi

clean:
					if test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -eq 1; then \
						echo "$(YELLOW) All services are already removed$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml down; \
						echo "$(GREEN) All services are removed$(END)"; \
					fi

fclean:				clean
					if test -d "/home/auzun/data/mariadb/" && test -d "/home/auzun/data/wordpress/"; then \
						sudo rm -rf $(VOLUMES_PATH); \
						echo "$(GREEN) The volumes have been successfully deleted$(END)"; \
					else \
						echo "$(YELLOW) Volumes are already removed$(END)"; \
					fi

re:					fclean
					make --no-print-directory all

.PHONY:				all up down clean fclean re
.SILENT:
