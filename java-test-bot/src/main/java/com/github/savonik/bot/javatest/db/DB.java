package com.github.savonik.bot.javatest.db;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class DB {

    private final String url;
    private Connection conn;

    public DB(String url) {
        this.url = url;
    }

    private Connection getConnection() {
        if (conn == null) {
            try {
                conn = DriverManager.getConnection(url);
            } catch (SQLException e) {
                throw new IllegalStateException("Failed to connect to DB", e);
            }
        }
        return conn;
    }

    public <T> List<T> getAll(Class<T> type, Object id) {
        Table table = type.getAnnotation(Table.class);

        if (table == null) {
            throw new IllegalArgumentException("No object associated with DB: " + type);
        }
        String tableName = table.value();

        List<Field> fields = new ArrayList<>();
        for (Field field : type.getDeclaredFields()) {
            if (field.isAnnotationPresent(Column.class)) {
                field.setAccessible(true);
                fields.add(field);
            }
        }
        String fieldNames = getStringFieldNames(fields);

        String idColumn = null;

        for (Field field : type.getDeclaredFields()) {
            if (field.isAnnotationPresent(ID.class)) {
                idColumn = field.getAnnotation(Column.class).value();
            }
        }

        final String queryTemplate = "SELECT %s FROM %s WHERE %s = %s";
        String query = String.format(queryTemplate, fieldNames, tableName, idColumn, id);
        System.out.println(query);

        List<T> objects = new ArrayList<>();
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                T obj = type.newInstance();
                for (Field field : fields) {
                    Column column = field.getAnnotation(Column.class);
                    field.set(obj, column.convert().newInstance().convert(rs.getObject(column.value())));
                }
                objects.add(obj);
            }
        } catch (SQLException e) {
            throw new IllegalStateException("Failed to get " + type.getName(), e);
        } catch (IllegalAccessException | InstantiationException e) {
            throw new IllegalStateException("Failed to create an instance of " + type.getName(), e);
        }

        return objects;
    }

    public <T> List<T> getAll(Class<T> type) {
        Table table = type.getAnnotation(Table.class);
        if (table == null) {
            throw new IllegalArgumentException("No object associated with DB: " + type);
        }
        String tableName = table.value();

        List<Field> fields = getFields(type);
        
        String fieldNames = getStringFieldNames(fields);

        final String queryTemplate = "SELECT %s FROM %s";
        String query = String.format(queryTemplate, fieldNames, tableName);
        System.out.println(query);

        List<T> objects = new ArrayList<>();
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                T obj = type.newInstance();
                for (Field field : fields) {
                    Column column = field.getAnnotation(Column.class);
                    field.set(obj, column.convert().newInstance().convert(rs.getObject(column.value())));
                }
                objects.add(obj);
            }
        } catch (SQLException e) {
            throw new IllegalStateException("Failed to get " + type.getName(), e);
        } catch (IllegalAccessException | InstantiationException e) {
            throw new IllegalStateException("Failed to create an instance of " + type.getName(), e);
        }

        return objects;
    }

    public <T> T getRandom(Class<T> type) {
        
        Table table = type.getAnnotation(Table.class);
        
        if (table == null) {
            throw new IllegalArgumentException("No object associated with DB: " + type);
        }
        
        String tableName = table.value();

        List<Field> fields = getFields(type);

        String fieldNames = getStringFieldNames(fields);

        final String queryTemplate = "SELECT %s FROM %s order by random() limit 1";
        String query = String.format(queryTemplate, fieldNames, tableName);
        System.out.println(query);
        
        T object = null;

        object = getObjectByType(type, object);

        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                for (Field field : fields) {
                    Column column = field.getAnnotation(Column.class);
                    field.set(object, column.convert().newInstance().convert(rs.getObject(column.value())));
                }
            }
        } catch (SQLException e) {
            throw new IllegalStateException("Failed to get " + type.getName(), e);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            throw new IllegalStateException("Failed to create an instance of " + type.getName(), e);
        }
        return object;
    }

    private <T> T getObjectByType(Class<T> type, T object) {
        try {
            object = type.newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            throw new IllegalStateException("Failed to create an instance of " + type.getName(), e);
        }
        return object;
    }

    private <T> List<Field> getFields(Class<T> type) {
        List<Field> fields = new ArrayList<>();
        for (Field field : type.getDeclaredFields()) {
            if (field.isAnnotationPresent(Column.class)) {
                field.setAccessible(true);
                fields.add(field);
            }
        }
        return fields;
    }

    private String getStringFieldNames(List<Field> fields) {
        return fields
                .stream()
                .map(field -> field.getAnnotation(Column.class).value())
                .collect(Collectors.joining(", "));
    }

}
